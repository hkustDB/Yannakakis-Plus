create or replace view aggView4315607912608379363 as select name as v41, id as v40 from name as n;
create or replace view aggJoin1110745471088011733 as (
with aggView5306520478939434541 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView5306520478939434541 where mi.info_type_id=aggView5306520478939434541.v15 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggView2711197007265308372 as select v49, v30 from aggJoin1110745471088011733 group by v49,v30;
create or replace view aggJoin6145528546803802593 as (
with aggView5593827232308855841 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView5593827232308855841 where mi_idx.info_type_id=aggView5593827232308855841.v17);
create or replace view aggView4941719409274151131 as select v49, v35 from aggJoin6145528546803802593 group by v49,v35;
create or replace view aggJoin1353876452326478340 as (
with aggView1666680539363896976 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select movie_id as v49 from movie_companies as mc, aggView1666680539363896976 where mc.company_id=aggView1666680539363896976.v8);
create or replace view aggJoin32854540238001845 as (
with aggView2871773877604757271 as (select v49 from aggJoin1353876452326478340 group by v49)
select id as v49, title as v50 from title as t, aggView2871773877604757271 where t.id=aggView2871773877604757271.v49);
create or replace view aggView1160927674553110601 as select v49, v50 from aggJoin32854540238001845 group by v49,v50;
create or replace view aggJoin561090536568762120 as (
with aggView6546498053804941104 as (select v40, MIN(v41) as v63 from aggView4315607912608379363 group by v40)
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView6546498053804941104 where ci.person_id=aggView6546498053804941104.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4818927098060063371 as (
with aggView7695777410786164559 as (select v49, MIN(v30) as v61 from aggView2711197007265308372 group by v49)
select v49, v35, v61 from aggView4941719409274151131 join aggView7695777410786164559 using(v49));
create or replace view aggJoin5385808563293814916 as (
with aggView5363679983703694163 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView5363679983703694163 where mk.keyword_id=aggView5363679983703694163.v19);
create or replace view aggJoin7772613631105133651 as (
with aggView3624905616836696216 as (select v49 from aggJoin5385808563293814916 group by v49)
select v49, v5, v63 as v63 from aggJoin561090536568762120 join aggView3624905616836696216 using(v49));
create or replace view aggJoin69352332216106233 as (
with aggView8713952025281342844 as (select v49, MIN(v63) as v63 from aggJoin7772613631105133651 group by v49,v63)
select v49, v35, v61 as v61, v63 from aggJoin4818927098060063371 join aggView8713952025281342844 using(v49));
create or replace view aggJoin4743423517157150243 as (
with aggView7182456816058784268 as (select v49, MIN(v61) as v61, MIN(v63) as v63, MIN(v35) as v62 from aggJoin69352332216106233 group by v49,v63,v61)
select v50, v61, v63, v62 from aggView1160927674553110601 join aggView7182456816058784268 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v50) as v64 from aggJoin4743423517157150243;
