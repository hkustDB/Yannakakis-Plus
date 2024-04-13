create or replace view aggView5187937539096817519 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4838965234059021494 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5187937539096817519 where mc.company_type_id=aggView5187937539096817519.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView227464504467673083 as select v15 from aggJoin4838965234059021494 group by v15;
create or replace view aggJoin7285300109131859360 as select id as v15, title as v16, production_year as v19 from title as t, aggView227464504467673083 where t.id=aggView227464504467673083.v15 and production_year>2010;
create or replace view aggView1692948484618889643 as select v15, MIN(v16) as v27 from aggJoin7285300109131859360 group by v15;
create or replace view aggJoin1294160755449064332 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1692948484618889643 where mi.movie_id=aggView1692948484618889643.v15 and info IN ('USA','America');
create or replace view aggView4505682531138360934 as select id as v3 from info_type as it;
create or replace view aggJoin5160079255119156821 as select v27 from aggJoin1294160755449064332 join aggView4505682531138360934 using(v3);
select MIN(v27) as v27 from aggJoin5160079255119156821;
