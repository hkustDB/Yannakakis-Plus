create or replace view aggView1737981057758914834 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView469068085275836914 as select id as v37, title as v38 from title as t;
create or replace view aggJoin1030299773126023966 as (
with aggView2224148209124600914 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2224148209124600914 where mi_idx.info_type_id=aggView2224148209124600914.v10);
create or replace view aggView1973198431523266549 as select v37, v23 from aggJoin1030299773126023966 group by v37,v23;
create or replace view aggJoin2304599814833959052 as (
with aggView2830146326708814436 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2830146326708814436 where mi.info_type_id=aggView2830146326708814436.v8);
create or replace view aggJoin8314938228941368146 as (
with aggView9127676611100204511 as (select v37, v18 from aggJoin2304599814833959052 group by v37,v18)
select v37, v18 from aggView9127676611100204511 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin3040409573580321460 as (
with aggView7805741527230153630 as (select v37, MIN(v18) as v49 from aggJoin8314938228941368146 group by v37)
select v37, v23, v49 from aggView1973198431523266549 join aggView7805741527230153630 using(v37));
create or replace view aggJoin2536274838303911532 as (
with aggView242000023639241897 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin3040409573580321460 group by v37,v49)
select person_id as v28, movie_id as v37, note as v5, v49, v50 from cast_info as ci, aggView242000023639241897 where ci.movie_id=aggView242000023639241897.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1076875470848273084 as (
with aggView5633551590509543010 as (select v28, MIN(v29) as v51 from aggView1737981057758914834 group by v28)
select v37, v5, v49 as v49, v50 as v50, v51 from aggJoin2536274838303911532 join aggView5633551590509543010 using(v28));
create or replace view aggJoin3924307980199305418 as (
with aggView7841471064358294340 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView7841471064358294340 where mk.keyword_id=aggView7841471064358294340.v12);
create or replace view aggJoin5640734207198436327 as (
with aggView6991571087694295656 as (select v37 from aggJoin3924307980199305418 group by v37)
select v37, v5, v49 as v49, v50 as v50, v51 as v51 from aggJoin1076875470848273084 join aggView6991571087694295656 using(v37));
create or replace view aggJoin2889365621555054306 as (
with aggView6830032816304163158 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v51) as v51 from aggJoin5640734207198436327 group by v37,v49,v50,v51)
select v38, v49, v50, v51 from aggView469068085275836914 join aggView6830032816304163158 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin2889365621555054306;
