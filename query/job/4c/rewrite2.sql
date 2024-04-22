create or replace view aggJoin2180462080207262977 as (
with aggView3822116271381136149 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView3822116271381136149 where mk.keyword_id=aggView3822116271381136149.v3);
create or replace view aggJoin4534746707988049191 as (
with aggView976650435922605587 as (select v14 from aggJoin2180462080207262977 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView976650435922605587 where t.id=aggView976650435922605587.v14 and production_year>1990);
create or replace view aggView7976190617178346424 as select v14, v15 from aggJoin4534746707988049191 group by v14,v15;
create or replace view aggJoin13090615083010836 as (
with aggView296120691679085558 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView296120691679085558 where mi_idx.info_type_id=aggView296120691679085558.v1);
create or replace view aggJoin3401604320509863686 as (
with aggView5130350573547231357 as (select v9, v14 from aggJoin13090615083010836 group by v9,v14)
select v14, v9 from aggView5130350573547231357 where v9>'2.0');
create or replace view aggJoin3873723057403752499 as (
with aggView1812908199860785779 as (select v14, MIN(v15) as v27 from aggView7976190617178346424 group by v14)
select v9, v27 from aggJoin3401604320509863686 join aggView1812908199860785779 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin3873723057403752499;
