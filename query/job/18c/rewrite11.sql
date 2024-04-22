create or replace view aggJoin1420854746656384889 as (
with aggView2161748793369262058 as (select id as v22 from name as n where gender= 'm')
select movie_id as v31, note as v5 from cast_info as ci, aggView2161748793369262058 where ci.person_id=aggView2161748793369262058.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin9013668914040536235 as (
with aggView26968173813591296 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView26968173813591296 where mi.info_type_id=aggView26968173813591296.v8 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin9071342982455714820 as (
with aggView8270390830182638779 as (select v31, MIN(v15) as v43 from aggJoin9013668914040536235 group by v31)
select movie_id as v31, info_type_id as v10, info as v20, v43 from movie_info_idx as mi_idx, aggView8270390830182638779 where mi_idx.movie_id=aggView8270390830182638779.v31);
create or replace view aggJoin4204664152283781689 as (
with aggView6497907064380620613 as (select id as v10 from info_type as it2 where info= 'votes')
select v31, v20, v43 from aggJoin9071342982455714820 join aggView6497907064380620613 using(v10));
create or replace view aggJoin1672370772399497258 as (
with aggView7621373315970156396 as (select v31, MIN(v43) as v43, MIN(v20) as v44 from aggJoin4204664152283781689 group by v31,v43)
select id as v31, title as v32, v43, v44 from title as t, aggView7621373315970156396 where t.id=aggView7621373315970156396.v31);
create or replace view aggJoin5072947965019728867 as (
with aggView5232905528775221997 as (select v31 from aggJoin1420854746656384889 group by v31)
select v32, v43 as v43, v44 as v44 from aggJoin1672370772399497258 join aggView5232905528775221997 using(v31));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v32) as v45 from aggJoin5072947965019728867;
