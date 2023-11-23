function prepBubbles(n){
  var positions = []


  function randomInt(min,max)
  {
      return Math.floor(Math.random()*(max-min+1)+min);
  }

  for (i = 0; i < n; i++) {
      positions.push({x: Math.floor(Math.random() * 100), y: Math.floor(Math.random() * 100), s: randomInt(1,20)})
  }

  return positions
  }

  function generateBubbles(n){
     var positions = prepBubbles(n)

      var bubbles = '';
      positions.forEach((position)=>{
          bubbles += position.x + 'vw ' + position.y + 'vh 0 ' + position.s + 'px #FFF, ' +
                   position.x + 'vw ' + (position.y + 100) + 'vh 0 ' + position.s + 'px #FFF, '
      })
    return bubbles
  }

  function generate()  {
      var bubbles = generateBubbles(21).slice(0, -2)
      var bubbles2 = generateBubbles(21).slice(0, -2)
      return `


  .bubbles::before,
  .bubbles::after{
    animation-name: bubbling;
    animation-timing-function: linear;
    animation-duration: 20s;
    animation-iteration-count: infinite;
  }
  .bubbles::after{
    box-shadow: ${bubbles};
  }
  .bubbles::before{
    box-shadow: ${bubbles2};
    animation-duration: 15s;
  }

  @keyframes bubbling {
          from {
              transform: translateY(0)
          }
          to {
              transform: translateY(-100vh)
          }
         }`
  }
