create or replace view aggJoin6617176532363244537 as (
with aggView8975198115021782866 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView8975198115021782866 where ci.person_id=aggView8975198115021782866.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1033361485768531017 as (
with aggView2707332046579318407 as (select v31 from aggJoin6617176532363244537 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView2707332046579318407 where t.id=aggView2707332046579318407.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggView1653417246127375418 as select v32, v31 from aggJoin1033361485768531017 group by v32,v31;
create or replace view aggJoin2586422390019658275 as (
with aggView5940220397183298978 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView5940220397183298978 where mi_idx.info_type_id=aggView5940220397183298978.v10 and info>'8.0');
create or replace view aggView1727586291383074693 as select v31, v20 from aggJoin2586422390019658275 group by v31,v20;
create or replace view aggJoin4746796818309597515 as (
with aggView3687683330909062153 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView3687683330909062153 where mi.info_type_id=aggView3687683330909062153.v8 and info IN ('Horror','Thriller'));
create or replace view aggView4655621067829091016 as select v15, v31 from aggJoin4746796818309597515 group by v15,v31;
create or replace view aggJoin5724709040897276536 as (
with aggView6977797887748640381 as (select v31, MIN(v32) as v45 from aggView1653417246127375418 group by v31)
select v31, v20, v45 from aggView1727586291383074693 join aggView6977797887748640381 using(v31));
create or replace view aggJoin4708764436886146703 as (
with aggView7600603391049025753 as (select v31, MIN(v45) as v45, MIN(v20) as v44 from aggJoin5724709040897276536 group by v31,v45)
select v15, v45, v44 from aggView4655621067829091016 join aggView7600603391049025753 using(v31));
select MIN(v15) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin4708764436886146703;
