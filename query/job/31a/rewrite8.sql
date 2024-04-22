create or replace view aggView7961278984232947324 as select title as v50, id as v49 from title as t;
create or replace view aggView4739336792798321071 as select name as v41, id as v40 from name as n where gender= 'm';
create or replace view aggJoin1419818648109067355 as (
with aggView6034036010376332426 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView6034036010376332426 where mk.keyword_id=aggView6034036010376332426.v19);
create or replace view aggJoin928591091504027717 as (
with aggView8880406089289050477 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8880406089289050477 where mi_idx.info_type_id=aggView8880406089289050477.v17);
create or replace view aggJoin8707553229171791459 as (
with aggView8682209492161954247 as (select v49 from aggJoin1419818648109067355 group by v49)
select movie_id as v49, company_id as v8 from movie_companies as mc, aggView8682209492161954247 where mc.movie_id=aggView8682209492161954247.v49);
create or replace view aggJoin5567516358164371892 as (
with aggView4456752702851945703 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49 from aggJoin8707553229171791459 join aggView4456752702851945703 using(v8));
create or replace view aggJoin4228433406103196228 as (
with aggView3993885188976078857 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView3993885188976078857 where mi.info_type_id=aggView3993885188976078857.v15);
create or replace view aggJoin3260726547335174355 as (
with aggView1213372088833599665 as (select v30, v49 from aggJoin4228433406103196228 group by v30,v49)
select v49, v30 from aggView1213372088833599665 where v30 IN ('Horror','Thriller'));
create or replace view aggJoin4602777005811130539 as (
with aggView2950111446627735709 as (select v49 from aggJoin5567516358164371892 group by v49)
select v49, v35 from aggJoin928591091504027717 join aggView2950111446627735709 using(v49));
create or replace view aggView7581242207525076287 as select v49, v35 from aggJoin4602777005811130539 group by v49,v35;
create or replace view aggJoin2836678019334621068 as (
with aggView636368323575427066 as (select v40, MIN(v41) as v63 from aggView4739336792798321071 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView636368323575427066 where ci.person_id=aggView636368323575427066.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8793512686402421843 as (
with aggView991720864095641956 as (select v49, MIN(v35) as v62 from aggView7581242207525076287 group by v49)
select v49, v30, v62 from aggJoin3260726547335174355 join aggView991720864095641956 using(v49));
create or replace view aggJoin1669980696469859822 as (
with aggView231310999570403604 as (select v49, MIN(v62) as v62, MIN(v30) as v61 from aggJoin8793512686402421843 group by v49,v62)
select v50, v49, v62, v61 from aggView7961278984232947324 join aggView231310999570403604 using(v49));
create or replace view aggJoin1977615871958798720 as (
with aggView8865138745762399745 as (select v49, MIN(v63) as v63 from aggJoin2836678019334621068 group by v49,v63)
select v50, v62 as v62, v61 as v61, v63 from aggJoin1669980696469859822 join aggView8865138745762399745 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin1977615871958798720;
