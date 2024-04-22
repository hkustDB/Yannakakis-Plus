create or replace view aggJoin5729454426274242987 as (
with aggView4369477042861539055 as (select movie_id as v40, MIN(title) as v52 from aka_title as aka_t group by movie_id)
select movie_id as v40, info_type_id as v22, note as v36, v52 from movie_info as mi, aggView4369477042861539055 where mi.movie_id=aggView4369477042861539055.v40 and note LIKE '%internet%');
create or replace view aggJoin8190042167537008703 as (
with aggView3669943110819428040 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, company_id as v13, company_type_id as v20, v53 from movie_companies as mc, aggView3669943110819428040 where mc.movie_id=aggView3669943110819428040.v40);
create or replace view aggJoin6254777785201311545 as (
with aggView6087844089297392637 as (select id as v13 from company_name as cn where country_code= '[us]')
select v40, v20, v53 from aggJoin8190042167537008703 join aggView6087844089297392637 using(v13));
create or replace view aggJoin4321846421864672619 as (
with aggView7029552713989326887 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v36, v52 from aggJoin5729454426274242987 join aggView7029552713989326887 using(v22));
create or replace view aggJoin2666560269176700177 as (
with aggView702038645129526170 as (select id as v20 from company_type as ct)
select v40, v53 from aggJoin6254777785201311545 join aggView702038645129526170 using(v20));
create or replace view aggJoin3069690574790386439 as (
with aggView3779970806541074158 as (select v40, MIN(v53) as v53 from aggJoin2666560269176700177 group by v40,v53)
select v40, v36, v52 as v52, v53 from aggJoin4321846421864672619 join aggView3779970806541074158 using(v40));
create or replace view aggJoin4300733943276585898 as (
with aggView4900084413783137788 as (select v40, MIN(v52) as v52, MIN(v53) as v53 from aggJoin3069690574790386439 group by v40,v53,v52)
select keyword_id as v24, v52, v53 from movie_keyword as mk, aggView4900084413783137788 where mk.movie_id=aggView4900084413783137788.v40);
create or replace view aggJoin1534530032022601395 as (
with aggView1844368276373121734 as (select id as v24 from keyword as k)
select v52, v53 from aggJoin4300733943276585898 join aggView1844368276373121734 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1534530032022601395;
