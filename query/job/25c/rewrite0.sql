create or replace view aggView8572872110543478439 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin7988028781118164108 as (
with aggView2605724375579289487 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2605724375579289487 where mi_idx.info_type_id=aggView2605724375579289487.v10);
create or replace view aggView4899677286616728150 as select v37, v23 from aggJoin7988028781118164108 group by v37,v23;
create or replace view aggJoin3210942953492380069 as (
with aggView3227688506778394319 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3227688506778394319 where mi.info_type_id=aggView3227688506778394319.v8);
create or replace view aggJoin3322636627744600491 as (
with aggView3959938420133526076 as (select v37, v18 from aggJoin3210942953492380069 group by v37,v18)
select v37, v18 from aggView3959938420133526076 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin1747802715083200567 as (
with aggView7240171591181388480 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView7240171591181388480 where mk.keyword_id=aggView7240171591181388480.v12);
create or replace view aggJoin6443286712738438492 as (
with aggView958377503670143995 as (select v37 from aggJoin1747802715083200567 group by v37)
select id as v37, title as v38 from title as t, aggView958377503670143995 where t.id=aggView958377503670143995.v37);
create or replace view aggView4231523283781255291 as select v37, v38 from aggJoin6443286712738438492 group by v37,v38;
create or replace view aggJoin2037157568743621015 as (
with aggView2322912848819170438 as (select v28, MIN(v29) as v51 from aggView8572872110543478439 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2322912848819170438 where ci.person_id=aggView2322912848819170438.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin112324056241054260 as (
with aggView2318166724321374419 as (select v37, MIN(v38) as v52 from aggView4231523283781255291 group by v37)
select v37, v5, v51 as v51, v52 from aggJoin2037157568743621015 join aggView2318166724321374419 using(v37));
create or replace view aggJoin5254607676063236385 as (
with aggView3247104488943144558 as (select v37, MIN(v51) as v51, MIN(v52) as v52 from aggJoin112324056241054260 group by v37,v52,v51)
select v37, v23, v51, v52 from aggView4899677286616728150 join aggView3247104488943144558 using(v37));
create or replace view aggJoin7709530538924963869 as (
with aggView5328856986677518976 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v23) as v50 from aggJoin5254607676063236385 group by v37,v52,v51)
select v18, v51, v52, v50 from aggJoin3322636627744600491 join aggView5328856986677518976 using(v37));
select MIN(v18) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7709530538924963869;
