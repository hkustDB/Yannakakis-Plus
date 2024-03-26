create or replace view aggView4416238649195638190 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7331867786944234852 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4416238649195638190 where mc.company_type_id=aggView4416238649195638190.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6984082728759065627 as select id as v3 from info_type as it;
create or replace view aggJoin5342862245255397523 as select movie_id as v15, info as v13 from movie_info as mi, aggView6984082728759065627 where mi.info_type_id=aggView6984082728759065627.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6531453047584354943 as select v15 from aggJoin5342862245255397523 group by v15;
create or replace view aggJoin1213055550382511065 as select v15, v9 from aggJoin7331867786944234852 join aggView6531453047584354943 using(v15);
create or replace view aggView5996516649206415605 as select v15 from aggJoin1213055550382511065 group by v15;
create or replace view aggJoin616902570051791388 as select title as v16 from title as t, aggView5996516649206415605 where t.id=aggView5996516649206415605.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin616902570051791388;
