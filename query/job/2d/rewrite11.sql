create or replace view aggView7206328352745145478 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8681151335268329418 as select movie_id as v12 from movie_keyword as mk, aggView7206328352745145478 where mk.keyword_id=aggView7206328352745145478.v18;
create or replace view aggView2979408492497616306 as select v12 from aggJoin8681151335268329418 group by v12;
create or replace view aggJoin3262900476377145119 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView2979408492497616306 where mc.movie_id=aggView2979408492497616306.v12;
create or replace view aggView7701369876966917075 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5044873702854602237 as select v12 from aggJoin3262900476377145119 join aggView7701369876966917075 using(v1);
create or replace view aggView6593054766540939621 as select v12 from aggJoin5044873702854602237 group by v12;
create or replace view aggJoin2313463030671579472 as select title as v20 from title as t, aggView6593054766540939621 where t.id=aggView6593054766540939621.v12;
select MIN(v20) as v31 from aggJoin2313463030671579472;
