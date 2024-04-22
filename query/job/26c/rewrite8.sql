create or replace view aggJoin6035876522972567376 as (
with aggView3987678992009572060 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3987678992009572060 where ci.person_role_id=aggView3987678992009572060.v9);
create or replace view aggJoin140402100903251691 as (
with aggView8397176827434759968 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView8397176827434759968 where cc.status_id=aggView8397176827434759968.v7);
create or replace view aggJoin218668084662211885 as (
with aggView6193972469882537066 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin140402100903251691 join aggView6193972469882537066 using(v5));
create or replace view aggJoin7084197424561654865 as (
with aggView8030004781966448931 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView8030004781966448931 where mi_idx.info_type_id=aggView8030004781966448931.v23);
create or replace view aggJoin6774389684489630226 as (
with aggView2338050642360360221 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2338050642360360221 where t.kind_id=aggView2338050642360360221.v28 and production_year>2000);
create or replace view aggJoin7184158289807102541 as (
with aggView4302715392413160861 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView4302715392413160861 where mk.keyword_id=aggView4302715392413160861.v25);
create or replace view aggJoin9036863518494000847 as (
with aggView2672287987740153952 as (select v47 from aggJoin7184158289807102541 group by v47)
select v47, v33 from aggJoin7084197424561654865 join aggView2672287987740153952 using(v47));
create or replace view aggJoin7508275786063926222 as (
with aggView1731730203890030802 as (select v47, MIN(v33) as v60 from aggJoin9036863518494000847 group by v47)
select v47, v48, v51, v60 from aggJoin6774389684489630226 join aggView1731730203890030802 using(v47));
create or replace view aggJoin7627076462269227255 as (
with aggView6993307551355940832 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin7508275786063926222 group by v47,v60)
select v47, v60, v61 from aggJoin218668084662211885 join aggView6993307551355940832 using(v47));
create or replace view aggJoin1854426105623234142 as (
with aggView8800271769466335784 as (select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin7627076462269227255 group by v47,v61,v60)
select v38, v59 as v59, v60, v61 from aggJoin6035876522972567376 join aggView8800271769466335784 using(v47));
create or replace view aggJoin8196903184324128479 as (
with aggView4458685278196582582 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin1854426105623234142 join aggView4458685278196582582 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8196903184324128479;
