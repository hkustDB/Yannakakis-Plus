create or replace view aggView348944803640318643 as select id as v3 from info_type as it;
create or replace view aggJoin8607499115334937403 as select movie_id as v15, info as v13 from movie_info as mi, aggView348944803640318643 where mi.info_type_id=aggView348944803640318643.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6464202425461999889 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin587666708443916615 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6464202425461999889 where mc.company_type_id=aggView6464202425461999889.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3142444695458702364 as select v15 from aggJoin587666708443916615 group by v15;
create or replace view aggJoin4250115646715803958 as select id as v15, title as v16, production_year as v19 from title as t, aggView3142444695458702364 where t.id=aggView3142444695458702364.v15 and production_year>2005;
create or replace view aggView1069142699090496257 as select v15, MIN(v16) as v27 from aggJoin4250115646715803958 group by v15;
create or replace view aggJoin894976409897741680 as select v27 from aggJoin8607499115334937403 join aggView1069142699090496257 using(v15);
select MIN(v27) as v27 from aggJoin894976409897741680;
