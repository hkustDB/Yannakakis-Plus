create or replace view aggJoin7382459971947931323 as (
with aggView5295162743214405372 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5295162743214405372 where ci.person_id=aggView5295162743214405372.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1561777587218991164 as (
with aggView6878286117335129550 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6878286117335129550 where mi.info_type_id=aggView6878286117335129550.v8 and info= 'Horror');
create or replace view aggJoin717488070771764201 as (
with aggView5978124441056885 as (select v37, MIN(v18) as v49 from aggJoin1561777587218991164 group by v37)
select id as v37, title as v38, production_year as v41, v49 from title as t, aggView5978124441056885 where t.id=aggView5978124441056885.v37 and production_year>2010 and title LIKE 'Vampire%');
create or replace view aggJoin3106824102953367910 as (
with aggView1195935188266407577 as (select v37, MIN(v51) as v51 from aggJoin7382459971947931323 group by v37,v51)
select v37, v38, v41, v49 as v49, v51 from aggJoin717488070771764201 join aggView1195935188266407577 using(v37));
create or replace view aggJoin5235389816018272355 as (
with aggView3194099124508142881 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView3194099124508142881 where mk.keyword_id=aggView3194099124508142881.v12);
create or replace view aggJoin1673417017396142343 as (
with aggView4040374602354362263 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4040374602354362263 where mi_idx.info_type_id=aggView4040374602354362263.v10);
create or replace view aggJoin6289689652842124694 as (
with aggView8847828775992513981 as (select v37, MIN(v23) as v50 from aggJoin1673417017396142343 group by v37)
select v37, v38, v41, v49 as v49, v51 as v51, v50 from aggJoin3106824102953367910 join aggView8847828775992513981 using(v37));
create or replace view aggJoin2149337553802751783 as (
with aggView76416612834700591 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50, MIN(v38) as v52 from aggJoin6289689652842124694 group by v37,v50,v49,v51)
select v49, v51, v50, v52 from aggJoin5235389816018272355 join aggView76416612834700591 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin2149337553802751783;
