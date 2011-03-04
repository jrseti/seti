<h1>Sessions</h1>

<table>
  <tr>
    <th>ID</th>
    <th>created_at</th>
    <th>updated_at</th>
    <th>Actions</th>
  </tr>

<% @sessions.each do |session| %>
  <tr>
    
    <td><%= session.session_id %></td>
    <td><%= session.created_at %></td>
    <td><%= session.updated_at %></td>
    <td><%= pattern.category %></td>
    <td><%= pattern.description %></td>
    <td><%= link_to 'Show', pattern %> | <%= link_to 'Edit', edit_pattern_path(pattern) %> |<%= link_to 'Destroy', pattern, :confirm => 'Are you sure?', :method => :delete %></td>
  </tr>
<% end %>
</table>

<br />

<%= link_to 'New Pattern', new_pattern_path %>
