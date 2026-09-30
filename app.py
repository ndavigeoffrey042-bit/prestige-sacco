from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Literal

app = FastAPI(title="Prestige SACCO Core API")

# Mock Database models for demonstration
class LoanRequest(BaseModel):
    member_id: int
    member_status: Literal["Active", "Inactive", "Suspended"]
    current_savings: float
    requested_loan_amount: float

@app.post("/api/loans/evaluate")
def evaluate_loan_eligibility(request: LoanRequest):
    # Rule 1: Account status validation
    if request.member_status != "Active":
        raise HTTPException(
            status_code=400, 
            detail=f"Loan denied. Member status is currently '{request.member_status}'."
        )
    
    # Rule 2: 3x Leverage Limit Calculation
    max_borrowing_limit = request.current_savings * 3
    
    if request.requested_loan_amount > max_borrowing_limit:
        return {
            "status": "Rejected",
            "reason": "Insufficient collateral multiplier.",
            "current_savings": request.current_savings,
            "maximum_allowed": max_borrowing_limit,
            "deficit": request.requested_loan_amount - max_borrowing_limit
        }
        
    return {
        "status": "Approved",
        "reason": "Loan application falls within valid 3x savings guidelines.",
        "requested_amount": request.requested_loan_amount,
        "maximum_limit": max_borrowing_limit
