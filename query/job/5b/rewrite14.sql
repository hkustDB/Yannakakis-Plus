create or replace view aggView6699205760711937283 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7894268553634486359 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView6699205760711937283 where mc.movie_id=aggView6699205760711937283.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView5296191201782640346 as select id as v3 from info_type as it;
create or replace view aggJoin1143918034119425908 as select movie_id as v15, info as v13 from movie_info as mi, aggView5296191201782640346 where mi.info_type_id=aggView5296191201782640346.v3 and info IN ('USA','America');
create or replace view aggView5484118603046973424 as select v15 from aggJoin1143918034119425908 group by v15;
create or replace view aggJoin4728128634549488075 as select v1, v9, v27 as v27 from aggJoin7894268553634486359 join aggView5484118603046973424 using(v15);
create or replace view aggView3414405259564269128 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3071400753453587254 as select v9, v27 from aggJoin4728128634549488075 join aggView3414405259564269128 using(v1);
select MIN(v27) as v27 from aggJoin3071400753453587254;
