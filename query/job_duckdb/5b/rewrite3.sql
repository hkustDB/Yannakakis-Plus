create or replace view aggView7274267960347432426 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3049299252892665572 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7274267960347432426 where mc.company_type_id=aggView7274267960347432426.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView70508028891652332 as select v15 from aggJoin3049299252892665572 group by v15;
create or replace view aggJoin2169466343071041608 as select id as v15, title as v16, production_year as v19 from title as t, aggView70508028891652332 where t.id=aggView70508028891652332.v15 and production_year>2010;
create or replace view aggView1649435351089377685 as select id as v3 from info_type as it;
create or replace view aggJoin721244281841097202 as select movie_id as v15, info as v13 from movie_info as mi, aggView1649435351089377685 where mi.info_type_id=aggView1649435351089377685.v3 and info IN ('USA','America');
create or replace view aggView5948111567563281393 as select v15, MIN(v16) as v27 from aggJoin2169466343071041608 group by v15;
create or replace view aggJoin7847509189149122923 as select v27 from aggJoin721244281841097202 join aggView5948111567563281393 using(v15);
select MIN(v27) as v27 from aggJoin7847509189149122923;
