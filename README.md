# hairfly
---
This is a demo booking app for web/android/ios by Flutter using GetX.

It is designed for customers to make a appointment on barber or salon (but the UI needs to be redesigned for both web and mobile.)

The shop admin page is still developing.

The backend is using firestore and firestorage for simplicity.

Visit https://hairfly-69e89.web.app/ for live demo.

---
## Screenshots

<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156541630-7a4974cb-fd5d-47a6-8e9f-172e9ae0b965.png", height="500" alt='main_page'/>
  <img src="https://user-images.githubusercontent.com/52627704/156541636-ddff0449-d5b6-4e71-966e-b0ee9f663fdf.png", height="500" alt='map'/>
  <img src="https://user-images.githubusercontent.com/52627704/156541648-c6a03c47-a953-44da-8c29-15746de600fc.png", height="500" alt='search_page'/>
</p>
<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156541624-e4aa8595-1a66-49a1-8eb0-8721b938a052.png", height="500" alt='status_page'/>
  <img src="https://user-images.githubusercontent.com/52627704/156541644-4e88b710-8a9a-428a-be17-f7bae2dd0d1c.png", height="500" alt='profile_page'/>
  <img src="https://user-images.githubusercontent.com/52627704/156541658-f0389f3e-7d18-44ac-afef-2a5f43cb37c5.png", height="500" alt='shop_details'/>
</p>

---
## Details (the gif is a bit low in fps with poor quality)
For the main page, it has 6 components
- A sliver appbar without pinning.
- The main dashboard directing to the search page.
- The carousel showing the results from different shops.
- The map showing all the locations.
- The shop list.
- The bottom nav bar.

<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156544090-555f75f3-67ac-4020-b010-ca954c806ce3.gif", height="500" alt='main_page'/>
  <img src="https://user-images.githubusercontent.com/52627704/156544903-3b8e5e6e-75b3-4da9-91f9-99349cb57ab3.gif", height="500" alt='map'/>
  <img src="https://user-images.githubusercontent.com/52627704/156544916-de56f9bd-dade-4c2e-b447-5ee3fce8f52c.gif", height="500" alt='locale'/>
</p>

For the booking page, it uses a calendar, a CupertinoDatePicker and a grouped radio buttoms for selection.

<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156546261-beaa635a-77a4-48ca-b724-59eafa867b1b.gif", height="500" alt='booking'/>
</p>


For the search page, it is just a demo to search the whole list in application side.
<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156545497-ed6c0a0a-c619-4292-91fa-747a37f23d56.gif", height="500" alt='search_page'/>
</p>

For the profile page, it can edit any personal data.
<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156546854-0f4ebae2-c08e-4143-b011-6f83a7a21016.gif", height="500" alt='search_page'/>
</p>

The profile page and the booking status page use a route guard for protection. It is done by implementing a middleware in the routing.
<p align='center'>
  <img src="https://user-images.githubusercontent.com/52627704/156547160-f17cd319-223c-4852-b1d9-71f1efe69f46.gif", height="500" alt='search_page'/>
</p>



