create or replace view aggView6452886913504236906 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8118961239801146985 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView6452886913504236906 where mc.movie_id=aggView6452886913504236906.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView5284009146702165351 as select id as v3 from info_type as it;
create or replace view aggJoin1538786532647885702 as select movie_id as v15, info as v13 from movie_info as mi, aggView5284009146702165351 where mi.info_type_id=aggView5284009146702165351.v3 and info IN ('USA','America');
create or replace view aggView645069070976214420 as select v15 from aggJoin1538786532647885702 group by v15;
create or replace view aggJoin5351076942113267384 as select v1, v9, v27 as v27 from aggJoin8118961239801146985 join aggView645069070976214420 using(v15);
create or replace view aggView8311950437455939966 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8772609853922768068 as select v9, v27 from aggJoin5351076942113267384 join aggView8311950437455939966 using(v1);
select MIN(v27) as v27 from aggJoin8772609853922768068;
