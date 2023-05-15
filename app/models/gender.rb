class Gender < ActiveHash::Base

  self.data = [
    { id: 1,  type: '男性' },
    { id: 2,  type: '女性' },
    { id: 3,  type: 'その他' }
  ]

end
