import flet as ft


def create_dashboard_header() -> ft.Container:
    return ft.Container(
        content=ft.Row(
            controls=[
                ft.Text("Dashboard", size=28, weight=ft.FontWeight.BOLD),
                ft.IconButton(icon=ft.Icons.NOTIFICATIONS_OUTLINED),
            ],
            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
        ),
        padding=20,
    )


def create_balance_card() -> ft.Container:
    return ft.Container(
        content=ft.Column(
            controls=[
                ft.Text(
                    "Total Balance",
                    size=14,
                    color=ft.Colors.GREY_700,
                ),
                ft.Text(
                    "$5,240.00",
                    size=24,
                    weight=ft.FontWeight.BOLD,
                ),
                ft.Row(
                    controls=[
                        ft.Icon(
                            ft.Icons.TRENDING_UP,
                            color=ft.Colors.GREEN,
                            size=16,
                        ),
                        ft.Text(
                            "+12.5%",
                            size=12,
                            color=ft.Colors.GREEN,
                        ),
                    ],
                ),
            ],
            spacing=5,
        ),
        bgcolor=ft.Colors.BLUE_50,
        border_radius=12,
        padding=20,
        expand=1,
    )


def create_dashboard_income_card() -> ft.Container:
    return ft.Container(
        content=ft.Column(
            controls=[
                ft.Text(
                    "Income",
                    size=14,
                    color=ft.Colors.GREY_700,
                ),
                ft.Text(
                    "$8,200.00",
                    size=24,
                    weight=ft.FontWeight.BOLD,
                ),
                ft.Text(
                    "This month",
                    size=12,
                    color=ft.Colors.GREY_600,
                ),
            ],
            spacing=5,
        ),
        bgcolor=ft.Colors.GREEN_50,
        border_radius=12,
        padding=20,
        expand=1,
    )


# Page 1: Dashboard/Analytics
def create_dashboard():
    return ft.Container(
        content=ft.Column(
            controls=[
                # Header
                create_dashboard_header(),
                # Summary Cards
                ft.Container(
                    content=ft.Row(
                        controls=[
                            # Total Balance Card
                            create_balance_card(),
                            # Income Card
                            create_dashboard_income_card(),
                            # Expenses Card
                            ft.Container(
                                content=ft.Column(
                                    controls=[
                                        ft.Text(
                                            "Expenses",
                                            size=14,
                                            color=ft.Colors.GREY_700,
                                        ),
                                        ft.Text(
                                            "$2,960.00",
                                            size=24,
                                            weight=ft.FontWeight.BOLD,
                                        ),
                                        ft.Text(
                                            "This month",
                                            size=12,
                                            color=ft.Colors.GREY_600,
                                        ),
                                    ],
                                    spacing=5,
                                ),
                                bgcolor=ft.Colors.RED_50,
                                border_radius=12,
                                padding=20,
                                expand=1,
                            ),
                        ],
                        spacing=15,
                    ),
                    padding=ft.Padding.only(left=20, right=20, bottom=20),
                ),
                # Charts Section
                ft.Container(
                    content=ft.Column(
                        controls=[
                            ft.Text(
                                "Spending Overview",
                                size=20,
                                weight=ft.FontWeight.BOLD,
                            ),
                            # Placeholder for Line Chart
                            ft.Container(
                                content=ft.Column(
                                    controls=[
                                        ft.Text(
                                            "Monthly Spending Trend",
                                            size=14,
                                            color=ft.Colors.GREY_700,
                                        ),
                                        ft.Container(
                                            content=ft.Text(
                                                "[Line Chart Visualization]\nShowing spending trends over 6 months",
                                                text_align=ft.TextAlign.CENTER,
                                                color=ft.Colors.GREY_500,
                                            ),
                                            bgcolor=ft.Colors.GREY_100,
                                            height=200,
                                            border_radius=8,
                                            alignment=ft.Alignment.CENTER,
                                        ),
                                    ],
                                    spacing=10,
                                ),
                                padding=15,
                                bgcolor=ft.Colors.WHITE,
                                border=ft.Border.all(1, ft.Colors.GREY_300),
                                border_radius=12,
                            ),
                        ],
                        spacing=15,
                    ),
                    padding=20,
                ),
                # Category Breakdown
                ft.Container(
                    content=ft.Column(
                        controls=[
                            ft.Text(
                                "Category Breakdown",
                                size=20,
                                weight=ft.FontWeight.BOLD,
                            ),
                            ft.Row(
                                controls=[
                                    # Pie Chart Placeholder
                                    ft.Container(
                                        content=ft.Column(
                                            controls=[
                                                ft.Container(
                                                    content=ft.Text(
                                                        "[Pie Chart]\nExpense Categories",
                                                        text_align=ft.TextAlign.CENTER,
                                                        color=ft.Colors.GREY_500,
                                                    ),
                                                    bgcolor=ft.Colors.GREY_100,
                                                    height=180,
                                                    border_radius=8,
                                                    alignment=ft.Alignment.CENTER,
                                                ),
                                            ],
                                        ),
                                        expand=1,
                                        padding=10,
                                        bgcolor=ft.Colors.WHITE,
                                        border=ft.Border.all(1, ft.Colors.GREY_300),
                                        border_radius=12,
                                    ),
                                    # Legend
                                    ft.Container(
                                        content=ft.Column(
                                            controls=[
                                                ft.Text(
                                                    "Categories",
                                                    weight=ft.FontWeight.BOLD,
                                                    size=14,
                                                ),
                                                *[
                                                    ft.Row(
                                                        controls=[
                                                            ft.Container(
                                                                width=12,
                                                                height=12,
                                                                bgcolor=color,
                                                                border_radius=2,
                                                            ),
                                                            ft.Text(label, size=12),
                                                            ft.Text(
                                                                value,
                                                                size=12,
                                                                weight=ft.FontWeight.BOLD,
                                                            ),
                                                        ],
                                                        spacing=8,
                                                    )
                                                    for label, value, color in [
                                                        (
                                                            "Food & Dining",
                                                            "$820",
                                                            ft.Colors.BLUE,
                                                        ),
                                                        (
                                                            "Transportation",
                                                            "$340",
                                                            ft.Colors.GREEN,
                                                        ),
                                                        (
                                                            "Shopping",
                                                            "$560",
                                                            ft.Colors.ORANGE,
                                                        ),
                                                        (
                                                            "Entertainment",
                                                            "$180",
                                                            ft.Colors.PURPLE,
                                                        ),
                                                        (
                                                            "Bills",
                                                            "$1,060",
                                                            ft.Colors.RED,
                                                        ),
                                                    ]
                                                ],
                                            ],
                                            spacing=12,
                                        ),
                                        expand=1,
                                        padding=15,
                                        bgcolor=ft.Colors.WHITE,
                                        border=ft.Border.all(1, ft.Colors.GREY_300),
                                        border_radius=12,
                                    ),
                                ],
                                spacing=15,
                            ),
                        ],
                        spacing=15,
                    ),
                    padding=20,
                ),
            ],
            scroll=ft.ScrollMode.AUTO,
            expand=True,
        ),
        expand=True,
    )
