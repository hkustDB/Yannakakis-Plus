create or replace view aggJoin7402694046316364680 as (
with aggView7123418357943074757 as (select id as v1 from company_name as cn where country_code= '[nl]')
select movie_id as v12 from movie_companies as mc, aggView7123418357943074757 where mc.company_id=aggView7123418357943074757.v1);
create or replace view aggJoin5911901753033295827 as (
with aggView6040373606216376881 as (select v12 from aggJoin7402694046316364680 group by v12)
select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView6040373606216376881 where mk.movie_id=aggView6040373606216376881.v12);
create or replace view aggJoin127881971663108358 as (
with aggView7419262769033828651 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select v12 from aggJoin5911901753033295827 join aggView7419262769033828651 using(v18));
create or replace view aggJoin7544510670951394197 as (
with aggView4525040755929859174 as (select v12 from aggJoin127881971663108358 group by v12)
select title as v20 from title as t, aggView4525040755929859174 where t.id=aggView4525040755929859174.v12);
create or replace view aggView5615933025543769417 as select v20 from aggJoin7544510670951394197 group by v20;
select MIN(v20) as v31 from aggView5615933025543769417;
