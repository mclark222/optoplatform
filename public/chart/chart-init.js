  const cashBurnRate = document.getElementById('cashBurnRateChart');
  const cashBurnRateChart = new Chart(cashBurnRate, {
      type: 'line',
      data: {
          labels: ['January', 'February', 'March', 'April', 'May', 'June'],
          datasets: [{
              label: 'Actual spend',
              data: [65, 59, 48, 56, 57, 40],
              backgroundColor: [
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                    ],
              borderColor: [
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                    ],
              borderWidth: 1
                }]
      },
      options: {
          scales: {
              y: {
                  beginAtZero: true
              }
          }
      }
  });


  const totalBudget = document.getElementById('totalBudgetChart');
  const totalBudgetChart = new Chart(totalBudget, {
      type: 'bar',
      data: {
        labels: [],
        //   labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
          datasets: [{
              label: 'Total Budget',
              data: [],
            //   data: [20, 14, 32, 14, 7, 22],
              backgroundColor: [
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                    ],
              borderColor: [
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                        'rgba(55, 81, 255, 1)',
                    ],
              borderWidth: 1
                }]
      },
      options: {
          scales: {
              y: {
                  beginAtZero: true
              }
          },
          legend: {
            display: false
          }
      }
  });


  
  function updateConfigByMutating(chart,label_entry,data_entry) {
    chart.data.labels = label_entry;
    chart.data.datasets.forEach((dataset) => {
        dataset.data = data_entry;
    });
    chart.update();
  }

//   function changeColor() {
//     var hello = document.getElementById('test');
//     if (hello.style.color == 'blue') {
//         hello.style.color = 'black';
//     }
//     else {
//         document.getElementById('test').style.color = 'blue';
//     } 
//   }
