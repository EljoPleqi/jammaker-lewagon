import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["countdown", "color"];
  static values = { prepTime: Number };

  connect() {
    console.log(this.colorTarget);
  }

  startCountdown() {
    let minInterval = this.prepTimeValue - 1;
    let secInterval = 60;
    let min_ = minInterval;
    let sec_ = secInterval;
    let css_ = 0;
    let counter = this.prepTimeValue * 60;
    const total = this.prepTimeValue * 60;

    const timer = setInterval(() => {
      if (min_ <= -1) {
        min_ = minInterval;
      }
      // this.countdownTarget.innerHTML = min_ + ":" + sec_-- + " Min";
      if (sec_ <= -1) {
        min_--;
        css_++;
        console.log(css_);
        sec_ = secInterval;
      }
      counter--;
      console.log(Math.round((counter / this.prepTimeValue) * 100));
      if (counter < 0) {
        clearInterval(timer);
      }
      this.colorTarget.style.height = `${Math.round(
        ((total - counter) / total) * 100
      )}%`;
    }, 1000);
  }
}
