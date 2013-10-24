function Trip(destination) {
  this.destination = destination;
}
Trip.prototype.start = function(numDays) {
  return 'Leaving for ' + this.destination +
    '! See you in ' + numDays + ' days.';
}
Trip.prototype.end = function(onDone) {
  onDone('Back to work :)');
}