create or replace view aggJoin5971153255742232456 as (
with aggView4423364102448564373 as (select id as v40, title as v53 from title as t where production_year>1990)
select movie_id as v40, title as v3, v53 from aka_title as aka_t, aggView4423364102448564373 where aka_t.movie_id=aggView4423364102448564373.v40);
create or replace view aggJoin4993278169767267082 as (
with aggView2582792677773389348 as (select v40, MIN(v53) as v53, MIN(v3) as v52 from aggJoin5971153255742232456 group by v40,v53)
select movie_id as v40, info_type_id as v22, note as v36, v53, v52 from movie_info as mi, aggView2582792677773389348 where mi.movie_id=aggView2582792677773389348.v40 and note LIKE '%internet%');
create or replace view aggJoin6866487516707422710 as (
with aggView1963496365871003000 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView1963496365871003000 where mc.company_id=aggView1963496365871003000.v13);
create or replace view aggJoin870042624797000408 as (
with aggView5119543564919101977 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v36, v53, v52 from aggJoin4993278169767267082 join aggView5119543564919101977 using(v22));
create or replace view aggJoin7758219695589634978 as (
with aggView2867394164704436179 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin870042624797000408 group by v40,v53,v52)
select v40, v20, v53, v52 from aggJoin6866487516707422710 join aggView2867394164704436179 using(v40));
create or replace view aggJoin609178240913280867 as (
with aggView460697735217689270 as (select id as v20 from company_type as ct)
select v40, v53, v52 from aggJoin7758219695589634978 join aggView460697735217689270 using(v20));
create or replace view aggJoin2109844032173040498 as (
with aggView7904872196041068018 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin609178240913280867 group by v40,v53,v52)
select keyword_id as v24, v53, v52 from movie_keyword as mk, aggView7904872196041068018 where mk.movie_id=aggView7904872196041068018.v40);
create or replace view aggJoin6491534292154778148 as (
with aggView3656446416974406984 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin2109844032173040498 join aggView3656446416974406984 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin6491534292154778148;
