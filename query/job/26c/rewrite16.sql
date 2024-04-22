create or replace view aggJoin6080540670909896918 as (
with aggView1937272137910007895 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1937272137910007895 where ci.person_role_id=aggView1937272137910007895.v9);
create or replace view aggJoin388070924166901489 as (
with aggView2728715904170295662 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView2728715904170295662 where cc.status_id=aggView2728715904170295662.v7);
create or replace view aggJoin9181279705622132599 as (
with aggView4541451118320042270 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin388070924166901489 join aggView4541451118320042270 using(v5));
create or replace view aggJoin4266803647849956740 as (
with aggView5799491635926195652 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5799491635926195652 where mi_idx.info_type_id=aggView5799491635926195652.v23);
create or replace view aggJoin6405235945051429169 as (
with aggView1688854305009149149 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1688854305009149149 where t.kind_id=aggView1688854305009149149.v28 and production_year>2000);
create or replace view aggJoin2186804156316063056 as (
with aggView7426843957450233413 as (select v47, MIN(v48) as v61 from aggJoin6405235945051429169 group by v47)
select v47, v61 from aggJoin9181279705622132599 join aggView7426843957450233413 using(v47));
create or replace view aggJoin6484898911464620451 as (
with aggView5586560624129385369 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5586560624129385369 where mk.keyword_id=aggView5586560624129385369.v25);
create or replace view aggJoin675736201116390146 as (
with aggView3577614472977449768 as (select v47 from aggJoin6484898911464620451 group by v47)
select v47, v33 from aggJoin4266803647849956740 join aggView3577614472977449768 using(v47));
create or replace view aggJoin5294372307687277202 as (
with aggView7239834784126958703 as (select v47, MIN(v33) as v60 from aggJoin675736201116390146 group by v47)
select v47, v61 as v61, v60 from aggJoin2186804156316063056 join aggView7239834784126958703 using(v47));
create or replace view aggJoin8158536080915512603 as (
with aggView756800990988281581 as (select v47, MIN(v61) as v61, MIN(v60) as v60 from aggJoin5294372307687277202 group by v47,v61,v60)
select v38, v59 as v59, v61, v60 from aggJoin6080540670909896918 join aggView756800990988281581 using(v47));
create or replace view aggJoin6123427298143090114 as (
with aggView9184713214027914854 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin8158536080915512603 join aggView9184713214027914854 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6123427298143090114;
