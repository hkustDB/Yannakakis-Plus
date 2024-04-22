create or replace view aggView4967714089602831434 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggView6882450965839000742 as select id as v45, title as v46 from title as t;
create or replace view aggJoin958958615527218760 as (
with aggView6899972525859869014 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView6899972525859869014 where mk.keyword_id=aggView6899972525859869014.v20);
create or replace view aggJoin4638589442127960458 as (
with aggView15953444707133615 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView15953444707133615 where cc.status_id=aggView15953444707133615.v7);
create or replace view aggJoin3465953402627099885 as (
with aggView3142509125251118431 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView3142509125251118431 where mi.info_type_id=aggView3142509125251118431.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin6746280554016641909 as (
with aggView8773846244556122954 as (select v45 from aggJoin958958615527218760 group by v45)
select v45, v5 from aggJoin4638589442127960458 join aggView8773846244556122954 using(v45));
create or replace view aggJoin3928280141518345285 as (
with aggView1209328914326677832 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin6746280554016641909 join aggView1209328914326677832 using(v5));
create or replace view aggJoin5097752764821555617 as (
with aggView9059515961160280773 as (select v45 from aggJoin3928280141518345285 group by v45)
select v45, v26 from aggJoin3465953402627099885 join aggView9059515961160280773 using(v45));
create or replace view aggView7603846148959951025 as select v45, v26 from aggJoin5097752764821555617 group by v45,v26;
create or replace view aggJoin6920411801954785350 as (
with aggView8914459700648269468 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView8914459700648269468 where mi_idx.info_type_id=aggView8914459700648269468.v18);
create or replace view aggView8508421113383473583 as select v45, v31 from aggJoin6920411801954785350 group by v45,v31;
create or replace view aggJoin987816832082174646 as (
with aggView1675395628658291262 as (select v45, MIN(v26) as v57 from aggView7603846148959951025 group by v45)
select v45, v31, v57 from aggView8508421113383473583 join aggView1675395628658291262 using(v45));
create or replace view aggJoin6192613818759889251 as (
with aggView1006161414859559984 as (select v45, MIN(v46) as v60 from aggView6882450965839000742 group by v45)
select v45, v31, v57 as v57, v60 from aggJoin987816832082174646 join aggView1006161414859559984 using(v45));
create or replace view aggJoin8848207572762652466 as (
with aggView7168913114191677630 as (select v45, MIN(v57) as v57, MIN(v60) as v60, MIN(v31) as v58 from aggJoin6192613818759889251 group by v45,v57,v60)
select person_id as v36, note as v13, v57, v60, v58 from cast_info as ci, aggView7168913114191677630 where ci.movie_id=aggView7168913114191677630.v45 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7372323886553964474 as (
with aggView960847149418327865 as (select v36, MIN(v57) as v57, MIN(v60) as v60, MIN(v58) as v58 from aggJoin8848207572762652466 group by v36,v57,v60,v58)
select v37, v57, v60, v58 from aggView4967714089602831434 join aggView960847149418327865 using(v36));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v37) as v59,MIN(v60) as v60 from aggJoin7372323886553964474;
