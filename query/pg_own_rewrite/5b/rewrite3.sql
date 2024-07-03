create or replace view aggView5280253064312072440 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8984164266583694923 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5280253064312072440 where mc.company_type_id=aggView5280253064312072440.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3198279725708519194 as select v15 from aggJoin8984164266583694923 group by v15;
create or replace view aggJoin5636623273627686529 as select id as v15, title as v16, production_year as v19 from title as t, aggView3198279725708519194 where t.id=aggView3198279725708519194.v15 and production_year>2010;
create or replace view aggView6886740801053256194 as select id as v3 from info_type as it;
create or replace view aggJoin5866824192911198484 as select movie_id as v15, info as v13 from movie_info as mi, aggView6886740801053256194 where mi.info_type_id=aggView6886740801053256194.v3 and info IN ('USA','America');
create or replace view aggView1914289295658221743 as select v15, MIN(v16) as v27 from aggJoin5636623273627686529 group by v15;
create or replace view aggJoin8507911196164776813 as select v27 from aggJoin5866824192911198484 join aggView1914289295658221743 using(v15);
select MIN(v27) as v27 from aggJoin8507911196164776813;
