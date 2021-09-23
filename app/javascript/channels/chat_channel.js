import consumer from "./consumer"

document.addEventListener('turbolinks:load', () =>
{
  let url = $('body').attr('data-url')

  // Check url
  if(url == 'chat')
  {
    get_user()

    let room = $('#room-chat').attr('data-value')
    let user_id = $('#chat-user-id').val()
    let receiver_id = $('#chat-receiver-id').val()
    
    let channel = consumer.subscriptions.create({channel: "ChatChannel", room_id: room}, {
      connected() {
        // Get message
        $.ajax({
          url: `/chat/get_chat?user_id=${receiver_id}`,
          success(data)
          {
            render_chat(data.chat)
          }
        })
      },
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
      received(data) {
        render_chat(data)
      }
    })

    $('#room-chat').on('change', ev =>
    {
      ev.preventDefault()

      let room = $('#room-chat').attr('data-value')
      let new_receiver_id = $('#chat-receiver-id').val()
      if(receiver_id != new_receiver_id)
      {
        receiver_id = new_receiver_id
        consumer.subscriptions.remove(channel)
        channel = consumer.subscriptions.create({channel: "ChatChannel", room_id: room}, {
          connected() {
            // Get message
            $.ajax({
              url: `/chat/get_chat?user_id=${receiver_id}`,
              success(data)
              {
                render_chat(data.chat)
              }
            })
          },
          disconnected() {
            // Called when the subscription has been terminated by the server
          },
          received(data) {
            render_chat(data)
          }
        })
      }
    })

    $('#form-chat').on('ajax:success', ev =>
    {
      ev.preventDefault()

      let message = $('#data-message').val()

      let [_data] = ev.detail

      console.log(_data)

      $('#data-message').val('')
    })
  }
})

function get_user()
{
  $.ajax({
    url: '/chat/get_user',
    success(data)
    {
      let html = ''
      $('#invox_chat').html('')
      data.map(r =>
      {
        html += `
        <a href="/chat/get_chat?user_id=${r.id}" id="user-${r.id}" data-remote="true">
          <div class="chat_list active_chat">
            <div class="chat_people">
              <div class="chat_img"> 
                <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> 
              </div>
              <div class="chat_ib">
                <h5>${r.email}</h5>
              </div>
            </div>
          </div>
        </a>
        `
      })
      $('#inbox_chat').html(html)
      
      get_chat(data)   
    }
  })
}

function get_chat(data)
{
  data.map(r =>
  {
    $(`#user-${r.id}`).on('ajax:success', ev =>
    {
      let [_data] = ev.detail

      window.history.pushState({}, '', `/chat/detail/${_data.room.id}/${r.id}`)
      $('#room-chat').attr('data-value', _data.room.id)
      $('#room-chat').val(_data.room.id)
      $('#room-chat').change()
      $('#chat-receiver-id').val(r.id)
      render_chat(_data.chat)
    })
  })
}

function render_chat(data)
{
  let html = ''
  if(data.length > 0)
  {
    data.map(r =>
    {
      html += `${
        r.sender_id == $('#chat-user-id').val() 
        ? `<div class="outgoing_msg">
            <div class="sent_msg">
              <p>
                ${r.message}
              </p>
              <span class="time_date">${r.created_at}</span> 
            </div>
          </div>`
        : `<div class="received_msg">
            <div class="received_withd_msg">
              <p>
                ${r.message}
              </p>
              <span class="time_date">${r.created_at}</span> 
            </div>
          </div>`
      }`
    })
    $('#coservation').html(html)
  }
  else
  {
    html += `${
      data.sender_id == $('#chat-user-id').val() 
      ? `<div class="outgoing_msg">
          <div class="sent_msg">
            <p>
              ${data.message}
            </p>
          </div>
        </div>`
      : `<div class="received_msg">
          <div class="received_withd_msg">
            <p>
              ${data.message}
            </p>
          </div>
        </div>`
    }`

    $('#coservation').append(html)
  }
  let elem        = document.getElementById('coservation')
  elem.scrollTop  = elem.scrollHeight
}