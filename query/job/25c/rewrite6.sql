create or replace view aggView612159012891913573 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView8203624506120363564 as select id as v37, title as v38 from title as t;
create or replace view aggJoin6558559629664265861 as (
with aggView8819205471604765438 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8819205471604765438 where mi_idx.info_type_id=aggView8819205471604765438.v10);
create or replace view aggView3406518510484404767 as select v37, v23 from aggJoin6558559629664265861 group by v37,v23;
create or replace view aggJoin5174993193782103021 as (
with aggView4895886909527529438 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView4895886909527529438 where mi.info_type_id=aggView4895886909527529438.v8);
create or replace view aggJoin5736891703654620575 as (
with aggView9196985559943498427 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView9196985559943498427 where mk.keyword_id=aggView9196985559943498427.v12);
create or replace view aggJoin7741666046145662010 as (
with aggView3235286092377724083 as (select v37 from aggJoin5736891703654620575 group by v37)
select v37, v18 from aggJoin5174993193782103021 join aggView3235286092377724083 using(v37));
create or replace view aggJoin6722207512857472341 as (
with aggView3597594466454214186 as (select v37, v18 from aggJoin7741666046145662010 group by v37,v18)
select v37, v18 from aggView3597594466454214186 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin905019868399585545 as (
with aggView1601174624837596088 as (select v37, MIN(v23) as v50 from aggView3406518510484404767 group by v37)
select v37, v18, v50 from aggJoin6722207512857472341 join aggView1601174624837596088 using(v37));
create or replace view aggJoin4802507119115661109 as (
with aggView5859749890025453916 as (select v28, MIN(v29) as v51 from aggView612159012891913573 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView5859749890025453916 where ci.person_id=aggView5859749890025453916.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7723897466518784712 as (
with aggView162990678924838118 as (select v37, MIN(v51) as v51 from aggJoin4802507119115661109 group by v37,v51)
select v37, v18, v50 as v50, v51 from aggJoin905019868399585545 join aggView162990678924838118 using(v37));
create or replace view aggJoin324562307342405409 as (
with aggView7875077683125489047 as (select v37, MIN(v50) as v50, MIN(v51) as v51, MIN(v18) as v49 from aggJoin7723897466518784712 group by v37,v50,v51)
select v38, v50, v51, v49 from aggView8203624506120363564 join aggView7875077683125489047 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin324562307342405409;
