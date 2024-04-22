create or replace view aggView3304172207185138111 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView557259208127174562 as select id as v37, title as v38 from title as t;
create or replace view aggJoin3727475104447712842 as (
with aggView3781076453569032732 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView3781076453569032732 where mi_idx.info_type_id=aggView3781076453569032732.v10);
create or replace view aggJoin8342953103084060558 as (
with aggView2290168953252277793 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView2290168953252277793 where mi.info_type_id=aggView2290168953252277793.v8);
create or replace view aggJoin3894815009410882827 as (
with aggView8853036643536421062 as (select v37, v18 from aggJoin8342953103084060558 group by v37,v18)
select v37, v18 from aggView8853036643536421062 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6863598155524608369 as (
with aggView3577775677128739745 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView3577775677128739745 where mk.keyword_id=aggView3577775677128739745.v12);
create or replace view aggJoin2347135906689207753 as (
with aggView5594305710501931061 as (select v37 from aggJoin6863598155524608369 group by v37)
select v37, v23 from aggJoin3727475104447712842 join aggView5594305710501931061 using(v37));
create or replace view aggView5696671502315241405 as select v37, v23 from aggJoin2347135906689207753 group by v37,v23;
create or replace view aggJoin1805413875963043913 as (
with aggView9166284621869520925 as (select v37, MIN(v23) as v50 from aggView5696671502315241405 group by v37)
select v37, v18, v50 from aggJoin3894815009410882827 join aggView9166284621869520925 using(v37));
create or replace view aggJoin1596833648752727385 as (
with aggView3784218826928932490 as (select v37, MIN(v50) as v50, MIN(v18) as v49 from aggJoin1805413875963043913 group by v37,v50)
select v37, v38, v50, v49 from aggView557259208127174562 join aggView3784218826928932490 using(v37));
create or replace view aggJoin8681067718025622968 as (
with aggView5684826308802221956 as (select v37, MIN(v50) as v50, MIN(v49) as v49, MIN(v38) as v52 from aggJoin1596833648752727385 group by v37,v49,v50)
select person_id as v28, note as v5, v50, v49, v52 from cast_info as ci, aggView5684826308802221956 where ci.movie_id=aggView5684826308802221956.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2257294406394997148 as (
with aggView686033020962920223 as (select v28, MIN(v50) as v50, MIN(v49) as v49, MIN(v52) as v52 from aggJoin8681067718025622968 group by v28,v49,v50,v52)
select v29, v50, v49, v52 from aggView3304172207185138111 join aggView686033020962920223 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin2257294406394997148;
