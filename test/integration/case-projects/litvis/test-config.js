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
    expectedOutput: '{"intTest":"5","floatTest":"5","boolTest":"True","stringTest":"\\"Hello world!\\"","stringTestWithSymbols":"\\"Can we handle {} [] \\\\\\" `` \\\\\\\\ ()? And a \\\\n new line?\\"","intListTest":"[1,2,3,4,5,6,7,8,9,10]","floatListTest":"[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5]","boolListTest":"[False,True,False,True,False,True,False,True,False,True]","stringListTest":"[\\"John\\",\\"Paul\\",\\"George\\",\\"Ringo\\"]","nestedIntTest":"[[1,2,3,4,5,6,7,8,9,10],[],[1,2,3,4,5,6,7,8,9,10]]","nestedFloatTest":"[[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5],[],[0.5,1,1.5,2,2.5,3,3.5,4,4.5,5]]","nestedBoolTest":"[[False,True,False,True,False,True,False,True,False,True],[],[False,True,False,True,False,True,False,True,False,True]]","nestedStringTest":"[[\\"John\\",\\"Paul\\",\\"George\\",\\"Ringo\\"],[],[\\"\\"],[\\"Ringo\\",\\"George\\",\\"Paul\\",\\"John\\"]]","tupleTest":"(\\"Hastings\\",1066)","tupleListTest":"[(\\"Hastings\\",1066),(\\"Hastings\\",1066),(\\"Hastings\\",1066),(\\"Hastings\\",1066)]","recordTest":"{ battle = \\"Hastings\\", date = 1066 }","recordTestWithAlias":"{ battle = \\"Hastings\\", date = 1066 }","add":"<function>","add6":"<function>","add6And8":"14"}',
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
