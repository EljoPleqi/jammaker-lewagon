import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-instruction-card',
  templateUrl: './instruction-card.component.html',
  styleUrls: ['./instruction-card.component.css'],
})
export class InstructionCardComponent implements OnInit {
  @Input() instruction!: { id: number; content: string };

  constructor() {}

  ngOnInit(): void {}
}
