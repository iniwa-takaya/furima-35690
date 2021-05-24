function price () {
  const priceInput = document.getElementById("item-price") ;
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const addTaxPrice = document.getElementById("add-tax-price");
    const addTax = Math.floor(inputValue * 0.1);
    addTaxPrice.innerHTML = addTax.toLocaleString();

    const profit = document.getElementById("profit");
    profit.innerHTML = Math.floor(inputValue - addTax).toLocaleString();
  })
};

window.addEventListener('load', price)