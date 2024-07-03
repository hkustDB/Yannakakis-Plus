create or replace view aggView3078073633546244109 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8266647089254746974 as select movie_id as v12 from movie_companies as mc, aggView3078073633546244109 where mc.company_id=aggView3078073633546244109.v1;
create or replace view aggView5020838726275786840 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4138828590563225281 as select v12, v31 from aggJoin8266647089254746974 join aggView5020838726275786840 using(v12);
create or replace view aggView6289380544281209859 as select v12, MIN(v31) as v31 from aggJoin4138828590563225281 group by v12,v31;
create or replace view aggJoin4129339796105822952 as select keyword_id as v18, v31 from movie_keyword as mk, aggView6289380544281209859 where mk.movie_id=aggView6289380544281209859.v12;
create or replace view aggView3750545767199984119 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3988727743248659205 as select v31 from aggJoin4129339796105822952 join aggView3750545767199984119 using(v18);
select MIN(v31) as v31 from aggJoin3988727743248659205;
