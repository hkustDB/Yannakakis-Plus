create or replace view aggView4377173546953648396 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6736473125446386036 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4377173546953648396 where mi.movie_id=aggView4377173546953648396.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7704389678548369155 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2735679625344062584 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7704389678548369155 where mc.company_type_id=aggView7704389678548369155.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2898502238798704019 as select v15 from aggJoin2735679625344062584 group by v15;
create or replace view aggJoin3061133381269767216 as select v3, v13, v27 as v27 from aggJoin6736473125446386036 join aggView2898502238798704019 using(v15);
create or replace view aggView1907630714876319764 as select v3, MIN(v27) as v27 from aggJoin3061133381269767216 group by v3;
create or replace view aggJoin2116155992877508017 as select v27 from info_type as it, aggView1907630714876319764 where it.id=aggView1907630714876319764.v3;
select MIN(v27) as v27 from aggJoin2116155992877508017;
