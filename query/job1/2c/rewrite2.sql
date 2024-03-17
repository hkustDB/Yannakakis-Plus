create or replace view aggView5253205897601167463 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4654282720513887664 as select movie_id as v12 from movie_keyword as mk, aggView5253205897601167463 where mk.keyword_id=aggView5253205897601167463.v18;
create or replace view aggView2600254434179005622 as select v12 from aggJoin4654282720513887664 group by v12;
create or replace view aggJoin4099607865426445983 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView2600254434179005622 where mc.movie_id=aggView2600254434179005622.v12;
create or replace view aggView174462915235872922 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6833735563622102781 as select v12 from aggJoin4099607865426445983 join aggView174462915235872922 using(v1);
create or replace view aggView1456488313558813050 as select v12 from aggJoin6833735563622102781 group by v12;
create or replace view aggJoin2476437870380758188 as select title as v20 from title as t, aggView1456488313558813050 where t.id=aggView1456488313558813050.v12;
select MIN(v20) as v31 from aggJoin2476437870380758188;
