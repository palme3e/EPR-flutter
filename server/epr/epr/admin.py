from django.contrib import admin
from .models import Language, Translation, ContentType, Content, AnswerType, Factor, Disease, References


class TranslationAdmin(admin.ModelAdmin):
    search_fields = ["language_code__code", "belongs_to__name"]


class ContentAdmin(admin.ModelAdmin):
    search_fields = ["name"]


admin.site.register(Language)
admin.site.register(Translation, TranslationAdmin)
admin.site.register(ContentType)
admin.site.register(Content, ContentAdmin)
admin.site.register(AnswerType)
admin.site.register(Factor)
admin.site.register(Disease)
admin.site.register(References)