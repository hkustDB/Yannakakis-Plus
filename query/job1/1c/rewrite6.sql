create or replace view aggView5174158950756237837 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin7507661816968668767 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5174158950756237837 where mc.movie_id=aggView5174158950756237837.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1656384158787166782 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4447980571200500160 as select v15, v9, v28, v29 from aggJoin7507661816968668767 join aggView1656384158787166782 using(v1);
create or replace view aggView7883193619326290671 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin1967816345628171108 as select movie_id as v15 from movie_info_idx as mi_idx, aggView7883193619326290671 where mi_idx.info_type_id=aggView7883193619326290671.v3;
create or replace view aggView4442887775534587659 as select v15 from aggJoin1967816345628171108 group by v15;
create or replace view aggJoin9054271917504604380 as select v9, v28 as v28, v29 as v29 from aggJoin4447980571200500160 join aggView4442887775534587659 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9054271917504604380;
