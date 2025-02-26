const updateRipples = () => {
  const buttonRipple: any =
    window.document.querySelectorAll('.ripple-animation');

  buttonRipple.forEach((button: any) => {
    button.onclick = ({
      pageY,
      currentTarget,
    }: {
      pageY: any;
      currentTarget: any;
    }) => {
      const x = 15;
      let y = pageY - currentTarget.offsetTop;
      if (y < 0) {
        y = 15;
      }
      const ripple = document.createElement('span');
      // make the style of the ripple with the overflow hidden
      ripple.classList.add('ripple-effect');
      ripple.style.left = `${x}px`;
      ripple.style.top = `${y}px`;
      button.appendChild(ripple);
      setTimeout(() => {
        ripple.remove();
      }, 600);
    };
  });
};

export default updateRipples;
