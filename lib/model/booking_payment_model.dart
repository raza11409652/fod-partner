class BookingPayment{
  final String id , time , startDate , endDate  ,room , elecRef , 
  period  , payDate , submittedOn , submitDate , mode , 
  modeRef , status , isPaidFlag , token ; 
  final double elecBill , rentBill , othersBill ;
  final int isPaid ;

  BookingPayment(this.id, this.time, this.startDate,
   this.endDate, this.room, this.elecRef, this.period, 
   this.payDate, this.submittedOn, this.submitDate, this.mode,
    this.modeRef, this.status, this.isPaidFlag, this.token,
     this.elecBill, this.rentBill, this.othersBill, this.isPaid); 
   
}