create or replace view aggJoin4512944072617043392 as (
with aggView8772228007175737467 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView8772228007175737467 where ci.person_id=aggView8772228007175737467.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3223442601835847690 as (
with aggView4849076083052155882 as (select v31 from aggJoin4512944072617043392 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView4849076083052155882 where t.id=aggView4849076083052155882.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggView2548383596293188746 as select v32, v31 from aggJoin3223442601835847690 group by v32,v31;
create or replace view aggJoin597176720973532064 as (
with aggView5495361412128392402 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView5495361412128392402 where mi.info_type_id=aggView5495361412128392402.v8 and info IN ('Horror','Thriller'));
create or replace view aggView6565424665992690655 as select v15, v31 from aggJoin597176720973532064 group by v15,v31;
create or replace view aggJoin5864319620445818382 as (
with aggView7395082098727668474 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView7395082098727668474 where mi_idx.info_type_id=aggView7395082098727668474.v10 and info>'8.0');
create or replace view aggView9070024413135128579 as select v31, v20 from aggJoin5864319620445818382 group by v31,v20;
create or replace view aggJoin7287260221078229786 as (
with aggView1273941324747974479 as (select v31, MIN(v32) as v45 from aggView2548383596293188746 group by v31)
select v15, v31, v45 from aggView6565424665992690655 join aggView1273941324747974479 using(v31));
create or replace view aggJoin7009262861165602284 as (
with aggView8183530944395287020 as (select v31, MIN(v45) as v45, MIN(v15) as v43 from aggJoin7287260221078229786 group by v31,v45)
select v20, v45, v43 from aggView9070024413135128579 join aggView8183530944395287020 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin7009262861165602284;
