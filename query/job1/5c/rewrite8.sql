create or replace view aggView3283800221630687309 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5412667150805762117 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView3283800221630687309 where mc.movie_id=aggView3283800221630687309.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5111298624139188399 as select id as v3 from info_type as it;
create or replace view aggJoin4939733391181336146 as select movie_id as v15, info as v13 from movie_info as mi, aggView5111298624139188399 where mi.info_type_id=aggView5111298624139188399.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1641465016218187325 as select v15 from aggJoin4939733391181336146 group by v15;
create or replace view aggJoin1232603059629239533 as select v1, v9, v27 as v27 from aggJoin5412667150805762117 join aggView1641465016218187325 using(v15);
create or replace view aggView3674578426284912746 as select v1, MIN(v27) as v27 from aggJoin1232603059629239533 group by v1;
create or replace view aggJoin5047356983915645627 as select kind as v2, v27 from company_type as ct, aggView3674578426284912746 where ct.id=aggView3674578426284912746.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin5047356983915645627;
