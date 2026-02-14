import flet as ft

from dashboard_page_0 import create_dashboard


def main(page: ft.Page):
    page.title = "Expensive Navigation Bar"
    page.theme_mode = ft.ThemeMode.LIGHT
    page.padding = 0

    current_page = ft.Ref[ft.Text]()

    content_area = ft.Container(expand=True)
    content_area.content = create_dashboard()

    def navigate(e) -> None:
        idx = e.control.selected_index
        if idx == 0:
            content_area.content = create_dashboard()
        elif idx == 1:
            content_area.content = ft.Container(
                ft.Text("Budget Page"),
                alignment=ft.Alignment.CENTER,
            )
        elif idx == 2:
            content_area.content = ft.Container(
                ft.Text(f"Selected: {e.control.selected_index}"),
                alignment=ft.Alignment.CENTER,
            )
        content_area.update()

    nav_bar = ft.NavigationBar(
        selected_index=0,
        destinations=[
            ft.NavigationBarDestination(
                icon=ft.Icons.DASHBOARD,
                label="Dashboard",
                selected_icon=ft.Icons.DASHBOARD_OUTLINED,
            ),
            ft.NavigationBarDestination(
                icon=ft.Icons.WALLET,
                label="Budget",
                selected_icon=ft.Icons.WALLET_OUTLINED,
            ),
            ft.NavigationBarDestination(
                icon=ft.Icons.SUPERVISED_USER_CIRCLE,
                selected_icon=ft.Icons.SUPERVISED_USER_CIRCLE_OUTLINED,
                label="Account",
            ),
        ],
        on_change=navigate,
    )

    page.add(
        ft.Column(
            controls=[
                content_area,
                nav_bar,
            ],
            spacing=0,
            expand=True,
        )
    )


if __name__ == "__main__":
    ft.run(main)
