create or replace view aggView2500579136019734529 as select id as v3 from info_type as it;
create or replace view aggJoin2807871533820264042 as select movie_id as v15, info as v13 from movie_info as mi, aggView2500579136019734529 where mi.info_type_id=aggView2500579136019734529.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2173424199398069659 as select v15 from aggJoin2807871533820264042 group by v15;
create or replace view aggJoin757116752849245321 as select id as v15, title as v16 from title as t, aggView2173424199398069659 where t.id=aggView2173424199398069659.v15 and production_year>2005;
create or replace view aggView4070947796597530373 as select v15, MIN(v16) as v27 from aggJoin757116752849245321 group by v15;
create or replace view aggJoin8448334177114308887 as select company_type_id as v1, v27 from movie_companies as mc, aggView4070947796597530373 where mc.movie_id=aggView4070947796597530373.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6335319063751158056 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2275072892240743977 as select v27 from aggJoin8448334177114308887 join aggView6335319063751158056 using(v1);
select MIN(v27) as v27 from aggJoin2275072892240743977;
