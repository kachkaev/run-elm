module.exports = [
  {
    title: 'hello world',
    functionArgs: ['HelloWorld.elm', { outputName: 'literateElmOutputSymbol' }],
    cliArgs: ['--output-name=literateElmOutputSymbol', 'HelloWorld.elm'],
    expectedOutput: '{"message":"\\"Hello world!!!\\""}',
    expectedError: ''
  },
  {
    title: 'multiple cases',
    functionArgs: ['MultipleCases.elm', { outputName: 'literateElmOutputSymbol' }],
    cliArgs: ['--output-name=literateElmOutputSymbol', 'MultipleCases.elm'],
    expectedOutput: '{"listOfInts":"[3,4,5,6,7,8,9,10,11,12,13]","booleanSymbol":"True"}',
    expectedError: ''
  },
  {
    title: 'simple chart',
    functionArgs: ['SimpleChart.elm', { outputName: 'literateElmOutputSymbol' }],
    cliArgs: ['--output-name=literateElmOutputSymbol', 'SimpleChart.elm'],
    expectedOutput: '{"barChart":"{ $schema = \\"https://vega.github.io/schema/vega-lite/v3.json\\", data = { url = \\"https://vega.github.io/vega-lite/data/cars.json\\" }, mark = \\"circle\\", encoding = { x = { field = \\"Horsepower\\", type = \\"quantitative\\" }, y = { field = \\"Miles_per_Gallon\\", type = \\"quantitative\\" }, color = { field = \\"Origin\\", type = \\"nominal\\" } } }"}',
    expectedError: ''
  }
];
