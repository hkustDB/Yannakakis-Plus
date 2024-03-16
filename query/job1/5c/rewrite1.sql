create or replace view aggView7602934491286945728 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7625167528584270761 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7602934491286945728 where mc.company_type_id=aggView7602934491286945728.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView7255828265636333103 as select v15 from aggJoin7625167528584270761 group by v15;
create or replace view aggJoin1678382127681553811 as select id as v15, title as v16 from title as t, aggView7255828265636333103 where t.id=aggView7255828265636333103.v15 and production_year>1990;
create or replace view aggView1685464713592455428 as select v15, MIN(v16) as v27 from aggJoin1678382127681553811 group by v15;
create or replace view aggJoin788007025648725319 as select info_type_id as v3, v27 from movie_info as mi, aggView1685464713592455428 where mi.movie_id=aggView1685464713592455428.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7139506358231926572 as select v3, MIN(v27) as v27 from aggJoin788007025648725319 group by v3;
create or replace view aggJoin9008630504802576693 as select v27 from info_type as it, aggView7139506358231926572 where it.id=aggView7139506358231926572.v3;
select MIN(v27) as v27 from aggJoin9008630504802576693;
