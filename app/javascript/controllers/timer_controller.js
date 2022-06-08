import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "countdown" ]
  static values = { prepTime: Number }

  connect() {
    console.log(this.countdownTarget)
    console.log(this.prepTimeValue)
  }

  startCountdown() {
    let minInterval = this.prepTimeValue -1;
    let secInterval = 60;
    let min_ = minInterval;
    let sec_ = secInterval;
    let counter = this.prepTimeValue *60;

   const timer = setInterval(() => {
     if( min_ <= -1) {
       min_ = minInterval;

     }
      this.countdownTarget.innerHTML = min_ +":"+sec_--+" Min";

     if (sec_ <= -1) {
        console.log (sec_);
        min_--;
        sec_ = secInterval;
     }
     counter--;
     console.log ((counter / this.prepTimeValue) )
     if (counter < 0) {
       clearInterval(timer);
     }

   }, 1000);
  }


}
