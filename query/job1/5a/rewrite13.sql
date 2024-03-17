create or replace view aggView8785135448288802755 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin3778406384047596944 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8785135448288802755 where mc.movie_id=aggView8785135448288802755.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6751658630820105262 as select id as v3 from info_type as it;
create or replace view aggJoin3539662925650286556 as select movie_id as v15, info as v13 from movie_info as mi, aggView6751658630820105262 where mi.info_type_id=aggView6751658630820105262.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6481056173698310119 as select v15 from aggJoin3539662925650286556 group by v15;
create or replace view aggJoin7333866789627778930 as select v1, v9, v27 as v27 from aggJoin3778406384047596944 join aggView6481056173698310119 using(v15);
create or replace view aggView419007171458653087 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin641580664765740232 as select v9, v27 from aggJoin7333866789627778930 join aggView419007171458653087 using(v1);
select MIN(v27) as v27 from aggJoin641580664765740232;
