create or replace view aggView4251985628416677121 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2502838760532152340 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4251985628416677121 where mc.company_type_id=aggView4251985628416677121.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView4435105018653543867 as select v15 from aggJoin2502838760532152340 group by v15;
create or replace view aggJoin3206839031711609007 as select id as v15, title as v16 from title as t, aggView4435105018653543867 where t.id=aggView4435105018653543867.v15 and production_year>2010;
create or replace view aggView8424399737506126529 as select id as v3 from info_type as it;
create or replace view aggJoin7854246541118754564 as select movie_id as v15 from movie_info as mi, aggView8424399737506126529 where mi.info_type_id=aggView8424399737506126529.v3 and info IN ('USA','America');
create or replace view aggView8159766288222710765 as select v15 from aggJoin7854246541118754564 group by v15;
create or replace view aggJoin8839134041681118026 as select v16 from aggJoin3206839031711609007 join aggView8159766288222710765 using(v15);
select MIN(v16) as v27 from aggJoin8839134041681118026;
