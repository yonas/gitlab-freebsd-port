# $FreeBSD$

PORTNAME=	gitlab
PORTVERSION=	8.1
CATEGORIES=	www

MAINTAINER=	yonas@fizk.net
COMMENT=	Web-based Git repository manager with wiki and issue tracking

LICENSE=	MIT

NO_BUILD=	yes

USERS=		gitlab
GROUPS=		gitlab

USE_GITHUB=	yes
GH_ACCOUNT=	gitlabhq
GH_PROJECT=	gitlabhq
GH_TAGNAME=	8-1-stable

GITLAB_BASE=	/home/gitlab

PLIST_SUB+=	GITLAB_BASE=${GITLAB_BASE}
SUB_LIST+=	GITLAB_BASE=${GITLAB_BASE}

do-install:
	${MKDIR} ${STAGEDIR}${GITLAB_BASE}/gitlab
	(cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${GITLAB_BASE}/gitlab)

.include <bsd.port.mk>
