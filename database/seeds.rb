Sop.create! name: 'SOP#1',
            desc: 'SOP#1 Description',
            author: '104502526',
            unit: 'NCUCC App Team',
            steps: ['step1 content', 'step2 content']

Sop.create! name: 'How to be a jerk',
            desc: 'What the fuck',
            author: 'Kirito Kun',
            unit: 'SAO Players',
            steps: ['C8763', 'Starbucks']

s = Sop.new
s.name = 'Nana no taizai'
s.desc = 'Good for your mid-term exam'
s.author = 'Marasy8'
s.unit = 'Konami'
s.steps = ['Flower', 'Jomanda']
s.save


Mark.create! uid: '104502526', sop_id: 1
